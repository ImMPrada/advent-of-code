module Year2024
  module Day14
    module Renderable # rubocop:disable Metrics/ModuleLength
      def render(title = nil)
        file_name = "./visualizations/day14/map_visualization_#{title}.html"
        html = generate_html
        File.write(file_name, html)
        puts "Visualization saved to #{file_name}"
        system("open #{file_name}")
      end

      private

      def generate_html
        <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
              html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
              }
              .container {
                height: 98vh;
                width: 98vw;
                max-width: 1200px;
                margin: 1vh auto;
                padding: 10px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
                overflow: hidden;
              }
              h1 {
                text-align: center;
                color: #333;
                margin: 0 0 10px 0;
                font-size: min(calc(16px + 1vw), 24px);
                flex: 0 0 auto;
              }
              .grid-container {
                flex: 1 1 auto;
                overflow: auto;
                padding: 5px;
                min-height: 0;
              }
              .grid {
                display: grid;
                grid-template-columns: repeat(#{cells.column_count}, 1fr);
                grid-auto-rows: 1fr;
                gap: 1px;
                background-color: #ccc;
                padding: 1px;
                height: min-content;
                min-width: min-content;
              }
              .cell {
                aspect-ratio: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: monospace;
                font-weight: bold;
                background-color: white;
                color: black;
                position: relative;
                min-width: min(20px, 4vw);
                min-height: min(20px, 4vh);
                font-size: min(calc(8px + 0.4vw), 14px);
              }
              .cell-content {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                width: 100%;
                height: 100%;
              }
              .cell-coords {
                font-size: 0.7em;
                color: #666;
                margin-bottom: 2px;
              }
              .in-quadrant {
                background-color: #f5f5f5;
              }
              .occupied {
                background-color: #ffebee;
              }
              @media (max-width: 768px) {
                .container {#{' '}
                  padding: 5px;
                  width: 100vw;
                  height: 100vh;
                  margin: 0;
                }
                .cell {#{' '}
                  min-width: 15px;
                  min-height: 15px;
                }
                h1 {
                  font-size: 16px;
                  margin: 5px 0;
                }
              }
            </style>
          </head>
          <body>
            <div class="container">
              <h1>Map Visualization</h1>
              <div class="grid-container">
                <div class="grid">
                  #{generate_cells_html}
                </div>
              </div>
            </div>
          </body>
          </html>
        HTML
      end

      def generate_cells_html # rubocop:disable Metrics/MethodLength
        cells.to_a.map do |row|
          row.map do |cell|
            occupants = cell.occupying.size
            cell_class = if occupants.positive?
                           'cell occupied'
                         elsif cell.in_quadrant
                           'cell in-quadrant'
                         else
                           'cell'
                         end

            next <<~HTML if occupants.zero?
              <div class="#{cell_class}"></div>
            HTML

            <<~HTML
              <div class="#{cell_class}">
                <div class="cell-content">
                  <div class="cell-coords">#{cell.x},#{cell.y}</div>
                  <div>#{occupants}</div>
                </div>
              </div>
            HTML
          end.join
        end.join
      end
    end
  end
end
