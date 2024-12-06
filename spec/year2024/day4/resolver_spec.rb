require 'spec_helper'

RSpec.describe Year2024::Day4::Resolver do
  subject(:resolver) { described_class.new(file_path) }

  let(:file_path) { nil }

  describe '#run_case1' do
    let(:file_path) { 'spec/year2024/day4/input.txt' }

    it 'returns the number of times the word "XMAS" appears' do
      expect(resolver.run_case1).to eq(18)
    end
  end

  describe '#run_case2' do
    let(:file_path) { 'spec/year2024/day4/input_part_two.txt' }

    it 'returns the number of times the word "MAS" on X appears' do
      expect(resolver.run_case2).to eq(9)
    end
  end

  describe '#find_word' do
    let(:puzzle) do
      Matrix[
        %w[s s m s o p a k n u s],
        %w[e w l e t r a s j p s],
        %w[m p s h b d s a s a j],
        %w[g e s a m o r e e l k],
        %w[r g m p p s e d s a t],
        %w[a r s o s u n s e b t],
        %w[t a h s r e z l v r c],
        %w[i t s z r i a l x a h],
        %w[s i p p y x a d e s p],
        %w[s s a j u g a r f m f]
      ]
    end

    context 'when looking for the word "sugar"' do
      let(:word) { 'sugar' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([])
      end
    end

    context 'when looking for the word "sopa"' do
      let(:word) { 'sopa' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word, word])
      end
    end

    context 'when looking for the word "letras"' do
      let(:word) { 'letras' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word])
      end
    end

    context 'when looking for the word "amor"' do
      let(:word) { 'amor' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word])
      end
    end

    context 'when looking for the word "palabras"' do
      let(:word) { 'palabras' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word])
      end
    end

    context 'when looking for the word "memoria"' do
      let(:word) { 'memoria' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word])
      end
    end

    context 'when looking for the word "puzle"' do
      let(:word) { 'puzle' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word])
      end
    end

    context 'when looking for the word "gratis"' do
      let(:word) { 'gratis' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word, word])
      end
    end

    context 'when looking for the word "aprende"' do
      let(:word) { 'aprende' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word])
      end
    end

    context 'when looking for the word "jugar"' do
      let(:word) { 'jugar' }

      it 'returns the word' do
        expect(resolver.find_word(puzzle, word)).to eq([word])
      end
    end
  end

  describe '#build_words' do
    let(:puzzle) do
      Matrix[
        %w[a b c d e f],
        %w[g h i j k l],
        %w[m n o p q r],
        %w[s t u v w x],
        %w[a b c d e f],
        %w[g h i j k l],
        %w[m n o p q r]
      ]
    end

    context 'when looking at 4, 4 and 4 letters_count' do
      let(:row) { 4 }
      let(:col) { 4 }
      let(:letters_count) { 4 }
      let(:expected_result) do
        %w[
          ewqk
          evoh
          edcb
        ]
      end

      it 'returns the words' do
        expect(resolver.build_words(puzzle, row, col, letters_count)).to eq(expected_result)
      end
    end

    context 'when looking at 0, 3 and 4 letters_count' do
      let(:row) { 0 }
      let(:col) { 3 }
      let(:letters_count) { 4 }
      let(:expected_result) do
        %w[
          dcba
          dins
          djpv
        ]
      end

      it 'returns the words' do
        expect(resolver.build_words(puzzle, row, col, letters_count)).to eq(expected_result)
      end
    end
  end
end
