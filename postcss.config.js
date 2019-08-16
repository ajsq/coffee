const purgecss = require("@fullhuman/postcss-purgecss");

class TachyonsExtractor {
  static extract(content) {
    return (content.match(/T\.\w+/g) || [])
      .map(c => c.substring(1))
      .map(c => c.replace(/_/g, '-'))
      .map(c => {console.log(c); return c});
  }
}

module.exports = {
  plugins: [
    purgecss({
      extractors: [
        {
          extensions: ["elm"],
          extractor: TachyonsExtractor
        }
      ],
      content: ["index.html","./src/**/*.elm"],
      whitelist: ["svg-inline--fa",
      "fa-sort-up",
      "fa-w-10",
       "fa-sort-down",
       "fa-sort"]
    })
  ]
}
