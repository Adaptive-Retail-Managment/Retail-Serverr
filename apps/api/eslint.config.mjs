import { nodeConfig } from '@arp/config/eslint/node';

export default nodeConfig({
  tsconfigRootDir: import.meta.dirname,
});
