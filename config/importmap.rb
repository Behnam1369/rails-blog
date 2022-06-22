# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
