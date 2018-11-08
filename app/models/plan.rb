class Plan < ApplicationRecord
  monetize :price_cents,  with_currency: :eur
end
