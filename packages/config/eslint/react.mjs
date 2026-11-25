import globals from 'globals';
import reactHooks from 'eslint-plugin-react-hooks';
import { baseConfig } from './base.mjs';

export function reactConfig(options = {}) {
  const config = baseConfig({
    ...options,
    files: options.files ?? ['**/*.{ts,tsx}'],
    globals: {
      ...globals.browser,
      ...(options.globals ?? {}),
    },
  });

  return [
    ...config,
    {
      files: options.files ?? ['**/*.{ts,tsx}'],
      plugins: {
        'react-hooks': reactHooks,
      },
      rules: {
        'react-hooks/rules-of-hooks': 'error',
        'react-hooks/exhaustive-deps': 'warn',
      },
    },
  ];
}
