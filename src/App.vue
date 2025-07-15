<template>
  <div id="app">
    <h1>19191919919</h1>

    <div id="wallet-connect"></div>

    <button id="sendTxBtn" disabled>发起交易</button>
  </div>
</template>

<script>
export default {
  name: "App",
  mounted() {
    this.demo()
  },
  methods: {
    demo() {
      // 初始化 TonConnect UI
      const tonConnectUI = new window.TON_CONNECT_UI.TonConnectUI({
        manifestUrl: "https://ljy-20.github.io/sim/tonconnect-manifest.json", // 替换成实际路径
        buttonRootId: "wallet-connect",
      });

      // 监听连接状态
      tonConnectUI.onStatusChange((wallet) => {
        console.log("连接状态变化:", wallet);
        const btn = document.getElementById("sendTxBtn");
        btn.disabled = !wallet || !wallet.account?.address;
      });

      // tonConnectUI.uiOptions = {
      //     twaReturnUrl: 'https://t.me/HH_Own_Test_Bot/HH_Own_Test_Mini_App'
      // };

      // 封装发送交易的方法
      async function sendTonTransaction() {
        const recipient = "EQCXXXXXXXXXXXXXXXXXXXXXXXXXXX"; // 替换为实际地址
        const amount = "10000000"; // 0.01 TON
        var a = new window.TonWeb.boc.Cell();
        a.bits.writeUint(0, 32);
        a.bits.writeString("9999999");
        console.log("a", a);
        var payload = window.TonWeb.utils.bytesToBase64(await a.toBoc());

        const tx = {
          validUntil: Math.floor(Date.now() / 1000) + 60,
          messages: [
            {
              address: recipient,
              amount: amount,
              payload: payload,
            },
          ],
        };

        try {
          const result = await tonConnectUI.sendTransaction(tx);
          // const result = await tonConnectUI.sendTransaction(tx, { skipRedirectToWallet: 'ios' });

          console.log("交易已发起:", result);
        } catch (err) {
          console.error("交易失败:", err);
        }
      }

      // 点击按钮先执行网络请求
      document
        .getElementById("sendTxBtn")
        .addEventListener("click", async () => {
          try {
            // 示例网络请求（你可以替换为你的接口）
            const response = await fetch(
              "https://jsonplaceholder.typicode.com/todos/1"
            );
            const data = await response.json();
            console.log("网络请求成功:", data);

            // 网络请求成功后再发起交易
            await sendTonTransaction();
          } catch (error) {
            console.error("网络请求失败:", error);
          }
        });
    },
  },
};
</script>

<style>
body {
  margin: 0;
  padding: 0;
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: #f7f7f7;
}

h1 {
  margin-bottom: 20px;
  font-size: 22px;
  text-align: center;
}

#sendTxBtn {
  margin-top: 20px;
  padding: 10px 20px;
  font-size: 16px;
}
</style>
