MoneyRails.configure do |config|
  config.default_currency = :eur  # or :gbp, :usd, etc.

  config.register_currency = {
      priority:            1,
      iso_code:            "EUR",
      name:                "Euro with currency at the end",
      symbol:              "€",
      symbol_first:        false,
      subunit:             "Subcent",
      subunit_to_unit:     100,
      thousands_separator: ".",
      decimal_mark:        ","
    }

end
