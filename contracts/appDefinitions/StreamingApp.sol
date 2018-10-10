pragma solidity 0.4.24;
pragma experimental "ABIEncoderV2";

import "../lib/Transfer.sol";


contract StreamingApp {

  enum ActionTypes {STREAM}

  struct Action {
    ActionTypes actionType;
    string _cid;
  }

  struct AppState {
    address artist;
    address user;
    uint256 streamingPrice;
    uint256 totalTransfer;
  }


  function getTurnTaker(AppState state) public pure returns (uint256) {
    return 0;
  }
  
  function isStateTerminal(AppState state) public pure returns (bool) {
    return true;
  }
  

  function resolve(AppState state, Transfer.Terms terms) public pure returns (Transfer.Transaction) {
    uint256[] memory amounts = new uint256[](2);
    amounts[0] = state.totalTransfer;
    amounts[1] = 0;
    address[] memory to = new address[](2);
    to[0] = state.artist;
    to[1] = state.user;
    bytes[] memory data = new bytes[](2);
    return Transfer.Transaction(terms.assetType,terms.token,to,amounts,data);
  }

  function applyAction(AppState state, Action action) public pure returns (bytes) {
    AppState memory newState;
    if (action.actionType == ActionTypes.STREAM) {
      newState = state;
      state.totalTransfer += state.streamingPrice;
    } else {
      revert("Invalid action type");
    }
    return abi.encode(newState);
  }

}