function checkAllBalances() {
  var i = 0;
  eth.accounts.forEach(function(e) {
    console.log("\t eth.accounts[" + i++ + "]: " + e + "\t balance: " + web3.fromWei(eth.getBalance(e), "ether") + "ether");
  });
}

function calcEtherToGas(ether, gasPrice) {
  console.log("\t GAS : " + web3.toWei(ether, 'ether') / gasPrice);
}
