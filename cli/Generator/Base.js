// Refer https://www.typescriptlang.org/docs/handbook/jsdoc-supported-types.html
import tailwindCss from "tailwindcss";
import resolveConfig from "tailwindcss/resolveConfig.js";
import * as postCss from "postcss";
import * as cssWhat from "css-what";

/*
 * _getBaseCssClassNames
 * This only generates base classnames.
 * Screens and Modifers are not generated.
 *
 * Main idea:
 * twConfigPath
 * -> postCss parse CSS
 * -> cssWhat parse class names
 * -> classNames[]
 *
 * it receive config path and input css from Purescript
 * it load TW config file and overwrite safelist with special pattern to generate all css
 * it use postCss to parse css from TW generation
 * it use cssWhat as another parser to gather css class name from postcss parsed info
 */
/** @type {( twConfig: tailwindcss.Config, inputCss: string ) => Promise<string[]>} */
export function _getBaseCssClassNames(twConfig) {
  return function (inputCss) {
    return async function (onError, onSuccess) {
      // Overwrite TW config
      const tailwindConfig = await overwriteTWConfig(twConfig);

      // Parsed css from TW css using postCss
      const parsedCss = await postCss
        .default([tailwindCss(tailwindConfig)])
        .process(inputCss, {
          from: "generated in-memory",
          to: "output in-memory",
        });

      if (parsedCss.root.type === "root") {
        // Extract class names into array then return
        onSuccess(extractClassNames(parsedCss.root));
      } else {
        // Throw error if cannot find any root css from parsed css
        onError(new Error("Cannot find root css"));
      }
    };
  };
}

/** @type {( config: tailwindcss.Config ) => Promise<tailwindcss.Config>} */
async function overwriteTWConfig(config) {
  return {
    ...config,
    // Don't let TW scan any file by adding invalid path
    // https://github.com/tailwindlabs/tailwindcss/blob/master/src/util/validateConfig.js
    content: ["intentionally.empty"],
    // Force all base classes to be generated
    safelist: [{ pattern: /.*/ }],
    // Don't let TW generate any variant
    variants: [],
  };
}

/** @type {( root: postCss.Root ) => string[]} */
function extractClassNames(root) {
  /** @type {( selectors: cssWhat.Selector[] ) => string[]} */
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
      /** @type {cssWhat.Selector[][]} */
      const selectors = cssWhat.parse(child.selector);
      const newClasses = go(selectors.flat(1));
      newClasses.forEach(classes.add, classes);
    }
  });
  return Array.from(classes);
}
