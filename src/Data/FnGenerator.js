import { join } from "path";
import tailwindCss from "tailwindcss";
import * as postCss from "postcss";
import * as cssWhat from "css-what";

/*
 * _getClasses
 * Main idea: TW generate CSS -> postCss parse CSS -> cssWhat parse class names
 * it receive config path and input css from Purescript
 * it load TW config file and overwrite safelist with special pattern to generate all css
 * it use postCss to parse css from TW generation
 * it use cssWhat as another parser to gather css class name from postcss parsed info
 */
export function _getClasses(twConfigPath) {
  return function (inputCss) {
    return async function (onError, onSuccess) {
      // Overwrite TW config
      const tailwindConfig = await overwriteTWConfig(twConfigPath);

      // Parsed css from TW css using postCss
      const parsedCss = await postCss
        .default([tailwindCss(tailwindConfig)])
        .process(inputCss, {
          from: "generated in-memory",
          to: "output in-memory",
        });

      if (parsedCss.root.type === "root") {
        // Extract class names into array then return
        onSuccess(getClasses(parsedCss.root));
      } else {
        // Throw error if cannot find any root css from parsed css
        onError(new Error("Cannot find root css"));
      }
    };
  };
}

async function overwriteTWConfig(path) {
  const originConfig = await import(join(process.cwd(), path));

  return {
    ...originConfig,
    // Don't let TW scan any file by adding invalid path
    // https://github.com/tailwindlabs/tailwindcss/blob/master/src/util/validateConfig.js
    content: ["intentionally.empty"],
    // Force all base classes
    safelist: [{ pattern: /.*/ }],
    // Don't let TW genrate any variant
    variants: [],
  };
}

function getClasses(root) {
  function go(selectors) {
    return selectors.reduce((acc, selector) => {
      if (selector.type === "attribute" && selector.name === "class") {
        acc.push(selector.value);
      }
      return acc;
    }, []);
  }

  const classes = new Set();
  root.each((child) => {
    if (child.type === "rule") {
      const selectors = cssWhat.parse(child.selector);
      const newClasses = go(selectors.flat(1));
      newClasses.forEach(classes.add, classes);
    }
  });
  return Array.from(classes);
}

// TODO: Need a function to to resolveConfig to get colors, screens,... to do pseudo functions
