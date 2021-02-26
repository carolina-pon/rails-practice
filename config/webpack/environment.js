const { environment } = require('@rails/webpacker')
// https://qiita.com/kazutosato/items/d47b7705ee545de4cb1a
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
)
module.exports = environment
