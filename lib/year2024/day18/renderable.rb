module Year2024
  module Day18
    module Renderable
      def render(path = nil, title: nil)
        html = generate_html(path, title)
        file_name = "./visualizations/day18/memory_#{title || Time.now.to_i}.html"

        FileUtils.mkdir_p(File.dirname(file_name))
        File.write(file_name, html)

        puts "Visualization saved to #{file_name}"
      end

      private

      def generate_html(path = nil, title = nil)
        <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <style>
              body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background-color: #f0f0f0;
              }
              .grid {
                display: grid;
                grid-template-columns: repeat(#{@size}, 20px);
                gap: 1px;
                background-color: #ccc;
                padding: 1px;
                width: fit-content;
                margin: 20px auto;
              }
              .cell {
                width: 20px;
                height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: monospace;
                font-weight: bold;
              }
              .safe { background-color: white; }
              .corrupted { background-color: #ff4444; }
              .path {#{' '}
                background-color: #44ff44;
                animation: pulse 2s infinite;
              }
              @keyframes pulse {
                0% { background-color: #44ff44; }
                50% { background-color: #88ff88; }
                100% { background-color: #44ff44; }
              }
              h1 {
                text-align: center;
                color: #333;
              }
              .stats {
                text-align: center;
                margin: 10px;
                font-family: monospace;
              }
            </style>
          </head>
          <body>
            <h1>Memory Space #{title}</h1>
            <div class="stats">
              Size: #{@size}x#{@size}<br>
              #{path ? "Path Length: #{path.size} steps" : 'No path found'}
            </div>
            <div class="grid">
              #{generate_cells_html(path)}
            </div>
          </body>
          </html>
        HTML
      end

      def generate_cells_html(path)
        @grid.to_a.map.with_index do |row, y|
          row.map.with_index do |cell, x|
            cell_class = if path&.include?([x, y])
                           'cell path'
                         elsif cell.corrupted
                           'cell corrupted'
                         else
                           'cell safe'
                         end

            "<div class='#{cell_class}'></div>"
          end.join
        end.join
      end
    end
  end
end
