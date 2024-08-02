import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const StreamingTokenModule = buildModule("StreamingTokenModule", (m) => {
  const streamingToken = m.contract("StreamingToken");

  return { streamingToken };
});

export default StreamingTokenModule;
