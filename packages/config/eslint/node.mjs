import globals from 'globals';
import { baseConfig } from './base.mjs';

export function nodeConfig(options = {}) {
  return baseConfig({
    ...options,
    globals: {
      ...globals.node,
      ...(options.globals ?? {}),
    },
  });
}
