import eslintConfigPrettier from 'eslint-config-prettier';
import globals from 'globals';
import tseslint from 'typescript-eslint';

const DEFAULT_IGNORES = [
  '**/node_modules/**',
  '**/dist/**',
  '**/dist-electron/**',
  '**/coverage/**',
  '**/*.d.ts',
];

/**
 * Shared flat ESLint config for TypeScript workspaces.
 * Deliberately not type-aware yet: fast enough for watch-mode use, can be
 * upgraded to `recommendedTypeChecked` once the schema and modules grow.
 */
export function baseConfig({
  files = ['**/*.ts'],
  tsconfigRootDir = process.cwd(),
  globals: extraGlobals = {},
  ignores = [],
} = {}) {
  return tseslint.config(
    { ignores: [...DEFAULT_IGNORES, ...ignores] },
    ...tseslint.configs.recommended,
    {
      files,
      languageOptions: {
        parser: tseslint.parser,
        parserOptions: {
          sourceType: 'module',
          tsconfigRootDir,
        },
        globals: {
          ...globals.es2023,
          ...extraGlobals,
        },
      },
      rules: {
        ...eslintConfigPrettier.rules,
        // TypeScript already resolves identifiers; no-undef produces false
        // positives for types and platform globals.
        'no-undef': 'off',
        '@typescript-eslint/no-unused-vars': [
          'error',
          {
            argsIgnorePattern: '^_',
            varsIgnorePattern: '^_',
            caughtErrorsIgnorePattern: '^_',
            ignoreRestSiblings: true,
          },
        ],
        'no-console': ['warn', { allow: ['warn', 'error'] }],
      },
    },
  );
}
