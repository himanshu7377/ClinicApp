# Pin npm packages by running ./bin/importmap

pin "application",  preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin  "@rails/ujs", to: "rails-ujs.js"



pin "chart.js", to: "https://cdn.skypack.dev/chart.js@3.7.0"
pin_all_from "https://cdn.skypack.dev", under: "chart.js"


pin "application"
pin "bootstrap", to: "bootstrap/dist/js/bootstrap.bundle.min.js"
