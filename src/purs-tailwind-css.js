#!/usr/bin/env node
import { dirname } from "path";
import { fileURLToPath } from "url";

import { run } from "./bundle/index.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

run(__dirname)();
