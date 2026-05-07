# Quinfy Rails Coding Challenge

A Ruby on Rails application for managing pizza orders.

The application displays pizza orders, calculates total prices dynamically using configurable pricing rules, and allows orders to be marked as completed.

---

## Features

- List all pizza orders
- Display pizza item details
- Dynamic pricing calculation
- Promotion code support
- Discount code support
- Mark orders as completed
- Hide completed orders from UI
- Config-driven pricing using YAML
- Automated tests using RSpec

---

## Tech Stack

- Ruby 3.3+
- Rails 8
- MySQL
- RSpec

---

## Clone Repository

```bash
git clone git@github.com:sanjaymohanta652/quinfy-rails-coding-challenge.git
cd quinfy-rails-coding-challenge
```
---

## Setup Instructions

### Install Dependencies

```bash
bundle install
```

### Setup Database

```bash
rails db:create
rails db:migrate
rails db:seed
```

### Start Server

```bash
rails server
```

Open in browser:

```text
http://localhost:3000
```

---

## Run Tests

```bash
bundle exec rspec
```

---

## Pricing Logic

Pricing is calculated dynamically using:

- Pizza base prices
- Size multipliers
- Extra ingredients
- Promotion codes
- Discount codes

Configuration is loaded from:

```text
data/config.yml
```

---

## Architecture Notes

Pricing logic is extracted into a dedicated service object:

```text
app/services/pricing/order_price_calculator.rb
```

Orders are loaded from JSON seed data:

```text
data/orders.json
```

Completed orders are hidden from the listing UI.