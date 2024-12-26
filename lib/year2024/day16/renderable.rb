module Year2024
  module Day16
    module Renderable # rubocop:disable Metrics/ModuleLength
      PATH_COLORS = [
        '#2196F3',  # Blue
        '#FFA726',  # Orange
        '#4CAF50',  # Green
        '#9C27B0',  # Purple
        '#FF5722',  # Deep Orange
        '#00BCD4',  # Cyan
        '#8BC34A',  # Light Green
        '#FF9800',  # Orange
        '#E91E63',  # Pink
        '#673AB7',  # Deep Purple
        '#009688',  # Teal
        '#CDDC39',  # Lime
        '#3F51B5',  # Indigo
        '#F44336'   # Red
      ].freeze

      def render(title = nil, paths = [])
        dir_path = './visualizations/day16'
        FileUtils.mkdir_p(dir_path) unless Dir.exist?(dir_path)

        file_name = "#{dir_path}/maze_visualization_#{title}.html"
        html = generate_html(paths)
        File.write(file_name, html)
        puts "Visualization saved to #{file_name}"
        system("open #{file_name}")
      end

      private

      def generate_html(paths)
        <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
              #{generate_styles(paths)}
            </style>
          </head>
          <body>
            <div class="container">
              <h1>Maze Visualization</h1>
              #{generate_stats_html(paths)}
              <div class="grid-container">
                <div class="grid">
                  #{generate_cells_html(paths)}
                </div>
              </div>
            </div>
          </body>
          </html>
        HTML
      end

      def generate_styles(paths) # rubocop:disable Metrics/MethodLength
        path_styles = paths.each_with_index.map do |_, index|
          color = PATH_COLORS[index % PATH_COLORS.size]
          ".path-#{index} { background-color: #{color}; color: white; }"
        end.join("\n")

        <<~CSS
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
          .stats {
            text-align: center;
            margin-bottom: 10px;
            color: #666;
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
          .wall { background-color: #000000; color: white; }
          .start { background-color: #4CAF50; color: white; }
          .end { background-color: #f44336; color: white; }
          #{path_styles}
          .direction {
            position: absolute;
            font-size: 0.8em;
            opacity: 0.8;
          }
        CSS
      end

      def generate_stats_html(paths)
        return '' if paths.empty?

        <<~HTML
          <div class="stats">
            Found #{paths.size} optimal paths<br>
            Total cost: #{paths.first.last[3]} points
          </div>
        HTML
      end

      def generate_cells_html(paths)
        path_cells = paths.each_with_index.map do |path, index|
          [path_to_set(path), index]
        end

        cells.to_a.map do |row|
          row.map do |cell|
            cell_class = cell_class_for(cell, path_cells)
            direction = direction_for_cell(cell, paths)

            <<~HTML
              <div class="#{cell_class}">
                #{direction_arrow(direction) if direction}
              </div>
            HTML
          end.join
        end.join
      end

      def cell_class_for(cell, path_cells)
        if cell == starting_cell
          'cell start'
        elsif cell == ending_cell
          'cell end'
        elsif cell.wall?
          'cell wall'
        else
          path_cells.each do |cells, index|
            return "cell path-#{index}" if cells.include?([cell.x, cell.y])
          end
          'cell'
        end
      end

      def path_to_set(path)
        Set.new(path.map { |x, y, _dir, _cost| [x, y] })
      end

      def direction_for_cell(cell, paths)
        paths.each do |path|
          found = path.find { |x, y, _dir, _cost| x == cell.x && y == cell.y }
          return found[2] if found
        end
        nil
      end

      def direction_arrow(direction)
        direction_arrows = {
          'N' => '↑',
          'E' => '→',
          'S' => '↓',
          'W' => '←'
        }
        arrow = direction_arrows[direction]
        %(<span class="direction">#{arrow}</span>)
      end
    end
  end
end
