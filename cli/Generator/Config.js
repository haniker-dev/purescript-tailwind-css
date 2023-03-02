import resolveConfig from "tailwindcss/resolveConfig.js";

/** @type {( path: string ) => Promise<tailwindcss.Config>} */
export function _loadConfig(twConfigPath) {
  return async function (onError, onSuccess) {
    try {
      const _config = await import(twConfigPath);
      const config = _config.default || _config;
      onSuccess(config);
    } catch (e) {
      onError(new Error(`Invalid config file found at: ${twConfigPath}`));
    }
  };
}

/** @type {( config: tailwindcss.Config ) => tailwindcss.ResolveConfig>} */
export function _resolveConfig(config) {
  return resolveConfig(config);
}
