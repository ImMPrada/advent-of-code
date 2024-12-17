module Year2024
  module Day12
    module Renderable
      COLORS = {
        'A' => '#FF0000', # red
        'B' => '#0000FF', # blue
        'C' => '#00FF00', # green
        'D' => '#FFFF00', # yellow
        'E' => '#FF00FF', # magenta
        'F' => '#00FFFF', # cyan
        'G' => '#800000', # maroon
        'H' => '#008000', # dark green
        'I' => '#000080', # navy
        'J' => '#808000', # olive
        'K' => '#800080', # purple
        'L' => '#008080', # teal
        'M' => '#FFA500', # orange
        'N' => '#FFC0CB', # pink
        'O' => '#A52A2A', # brown
        'P' => '#DDA0DD', # plum
        'Q' => '#F0E68C', # khaki
        'R' => '#E6E6FA', # lavender
        'S' => '#98FB98', # pale green
        'T' => '#DEB887', # burlywood
        'U' => '#CD853F', # peru
        'V' => '#FA8072', # salmon
        'W' => '#DC143C', # crimson
        'X' => '#40E0D0', # turquoise
        'Y' => '#EE82EE', # violet
        'Z' => '#FFD700'  # gold
      }.freeze

      def render
        html = generate_html
        File.write('garden_visualization.html', html)
        puts 'Visualization saved to garden_visualization.html'
        system('open garden_visualization.html') # Opens in default browser on macOS/Linux
      end

      private

      def generate_html
        <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <style>
              body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background-color: #f0f0f0;
                margin: 0;
              }
              .container {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                max-width: 95vw;
                margin: 0 auto;
              }
              .grid {
                display: grid;
                grid-template-columns: repeat(#{cells.column_count}, minmax(20px, 30px));
                gap: 1px;
                background-color: #ccc;
                padding: 1px;
                margin: 0 auto;
                width: fit-content;
                max-width: 100%;
                overflow-x: auto;
              }
              .cell {
                width: 100%;
                aspect-ratio: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: monospace;
                font-weight: bold;
                color: black;
                text-shadow: 1px 1px 1px rgba(255,255,255,0.5);
                font-size: clamp(0.8rem, 2vw, 1rem);
              }
              .legend {
                margin-top: 20px;
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                justify-content: center;
              }
              .legend-item {
                display: flex;
                align-items: center;
                gap: 5px;
                background-color: white;
                padding: 5px 10px;
                border-radius: 4px;
                box-shadow: 0 1px 2px rgba(0,0,0,0.1);
              }
              .color-box {
                width: 20px;
                height: 20px;
                border: 1px solid rgba(0,0,0,0.1);
                border-radius: 2px;
              }
              h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
              }
            </style>
          </head>
          <body>
            <div class="container">
              <h1>Garden Visualization</h1>
              <div class="grid">
                #{generate_cells_html}
              </div>
              #{generate_legend_html}
            </div>
          </body>
          </html>
        HTML
      end

      def generate_cells_html
        cells.to_a.map do |row|
          row.map do |cell|
            color = COLORS[cell.region_name] || '#FFFFFF'
            %(<div class="cell" style="background-color: #{color}">#{cell.region_name}</div>)
          end.join
        end.join
      end

      def generate_legend_html
        legend_items = regions_names.uniq.map do |name|
          color = COLORS[name] || '#FFFFFF'
          <<~HTML
            <div class="legend-item">
              <div class="color-box" style="background-color: #{color}"></div>
              <span>Region #{name}</span>
            </div>
          HTML
        end

        <<~HTML
          <div class="legend">
            #{legend_items.join}
          </div>
        HTML
      end
    end
  end
end
