# gman-services
[![Build Status](https://travis-ci.org/westernmilling/gman-services.svg?branch=master)](https://travis-ci.org/westernmilling/gman-services)
[![Code Climate](https://codeclimate.com/github/westernmilling/gman-services/badges/gpa.svg)](https://codeclimate.com/github/westernmilling/gman-services)
[![Test Coverage](https://codeclimate.com/github/westernmilling/gman-services/badges/coverage.svg)](https://codeclimate.com/github/westernmilling/gman-services/coverage)
[![Dependency Status](https://gemnasium.com/westernmilling/gman-services.svg)](https://gemnasium.com/westernmilling/gman-services)

## Getting Started

For development you will need both gman_services_dev and grossman_dev databases.

## Warning!

### Orders

Querying orders from Grossman can be a minefield, especially if you have a large
volume of orders in the system.

Due to a lack of indexes on the `Order` ("header") and `Order::Line` ("detail")
schemas it is recommended that the `OrderReference` ("cross reference") model
is used for querying orders.
