#!/usr/bin/env node
import { dirname } from "path";
import { fileURLToPath } from "url";

import { run } from "../output/Cli/index.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

run(__dirname)();
