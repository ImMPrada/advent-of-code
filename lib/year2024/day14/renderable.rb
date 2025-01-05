module Year2024
  module Day14
    module Renderable # rubocop:disable Metrics/ModuleLength
      def render(count = nil, title: nil)
        file_name = "./visualizations/day14/map_#{title ? "_#{title}" : ''}.html"
        html = generate_html(count)
        File.write(file_name, html)
        puts "Visualization saved to #{file_name}"
      end

      def render_histograms(data_arrays, page_title:, file_name: nil)
        file_name ||= './visualizations/day14/density_histograms.html'
        html = generate_histograms_html(data_arrays, page_title)

        File.write(file_name, html)
        puts "Histograms saved to #{file_name}"
        system("open #{file_name}")
      end

      private

      def generate_html(count = nil)
        <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
              html, body {
                height: 100vh;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
              }
              .container {
                max-height: 98vh;
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
              <h1>Map Visualization #{count}</h1>
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

      def generate_histograms_html(data_arrays, page_title) # rubocop:disable Metrics/MethodLength
        charts = data_arrays.map.with_index do |data, index|
          generate_chart_html(data, index)
        end

        <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <style>
              .chart-container {
                width: 600px;
                height: 400px;
                margin: 20px;
                padding: 10px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
              }
              .charts-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(640px, 1fr));
                gap: 20px;
                padding: 20px;
                background: #f0f0f0;
              }
              h1 {
                text-align: center;
                padding: 20px;
                margin: 0;
                background: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
              }
              .stats {
                font-size: 0.9em;
                color: #666;
                margin-top: 10px;
                text-align: center;
              }
            </style>
          </head>
          <body>
            <h1>#{page_title}</h1>
            <div class="charts-grid">
              #{charts.join("\n")}
            </div>
          </body>
          </html>
        HTML
      end

      def generate_chart_html(data, index) # rubocop:disable Metrics/MethodLength
        density_values = data[:density]
        skewness = data[:skewness]
        time = data[:time]
        stats = statistics(density_values)

        <<~HTML
          <div class="chart-container">
            <canvas id="chart#{index}"></canvas>
            <div class="stats">
              Skewness: #{skewness.round(3)}<br>
              Mean: #{stats[:mean].round(3)}<br>
              Median: #{stats[:median].round(3)}<br>
              StdDev: #{stats[:standard_deviation].round(3)}
              Time: #{time}
            </div>
            <script>
              new Chart(document.getElementById('chart#{index}'), {
                type: 'bar',
                data: {
                  labels: #{generate_histogram_labels(density_values)},
                  datasets: [{
                    label: 'Density Distribution',
                    data: #{generate_histogram_data(density_values)},
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                  }]
                },
                options: {
                  responsive: true,
                  maintainAspectRatio: false,
                  scales: {
                    y: {
                      beginAtZero: true
                    }
                  },
                  plugins: {
                    title: {
                      display: true,
                      text: 'Density Distribution at Time #{index}'
                    }
                  }
                }
              });
            </script>
          </div>
        HTML
      end

      def generate_histogram_data(values)
        min_val = values.min.floor
        max_val = values.max.ceil
        bin_size = ((max_val - min_val) / 20.0).ceil

        bins = Array.new(20, 0)
        values.each do |value|
          bin = ((value - min_val) / bin_size).floor
          bin = 19 if bin >= 20
          bins[bin] += 1
        end

        bins
      end

      def generate_histogram_labels(values)
        min_val = values.min.floor
        max_val = values.max.ceil
        bin_size = ((max_val - min_val) / 20.0).ceil

        (0..19).map { |i| (min_val + i * bin_size).round(1) }
      end
    end
  end
end
