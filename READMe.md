

---

# STX Tipping System

A decentralized tipping system built on the [Stacks](https://www.stacks.co/) blockchain, allowing users to easily send and receive STX tips in a transparent, trustless manner using Clarity smart contracts.

## Features

* 🔁 **Peer-to-peer tipping** using STX
* 📜 **Clarity smart contract** logic for secure and verifiable transactions
* 🧾 **Transparent on-chain records** of all tips sent and received
* 💼 **Wallet integration** for sending/receiving STX (via Hiro or other compatible wallets)

## Tech Stack

* **Stacks Blockchain**
* **Clarity** smart contracts
* **Stacks.js** for frontend blockchain interaction
* **React / Next.js / Vanilla JS** (depending on your frontend setup)

## Getting Started

### Prerequisites

* [Node.js](https://nodejs.org/)
* [Hiro Wallet](https://www.hiro.so/wallet/install-web)
* [Clarinet](https://docs.stacks.co/docs/clarity/clarinet-cli) (for smart contract development)

### Installation

```bash
git clone https://github.com/your-username/stx-tipping-system.git
cd stx-tipping-system
npm install
```

### Running Locally

Start your local dev environment and deploy contracts using Clarinet:

```bash
clarinet dev
```

Then run the frontend:

```bash
npm run dev
```

### Smart Contracts

The Clarity smart contract handles:

* Tip creation
* Tip claiming
* Logging tip metadata (sender, receiver, amount, timestamp)

Contract files are in `/contracts`.


## License

MIT © \AkanimoRex

---

