require 'date'
require_relative '../src/todos'

RSpec.describe Todos do
  described_class::FILEPATH = Pathname('files/test_todos.json')
  let(:todo1) { { 'title' => 'New Task 1', 'deadline' => DateTime.now, 'completed' => false } }
  let(:todo2) { { 'title' => 'New Task 2', 'deadline' => DateTime.now, 'completed' => false } }

  after do
    File.open(described_class::FILEPATH, 'w') do |f|
      JSON.dump([], f)
    end
  end

  describe '.add' do
    context 'when the todo does not already exist' do
      it 'adds a new todo' do
        expect { described_class.add(todo1['title'], todo1['deadline'], todo1['completed']) }.not_to raise_error
        expect(described_class.all.map { |todo| todo['title'] }).to include(todo1['title'])
      end
    end

    context 'when a todo with the same title already exists' do
      before { described_class.add(todo1['title'], todo1['deadline'], todo1['completed']) }
      it 'raises an AlreadyExistsError' do
        expect { described_class.add(todo1['title'], todo1['deadline']) }.to raise_error(described_class::AlreadyExistsError)
      end
    end
  end

  describe '.complete' do
    context 'when the todo exists and is not completed' do
      before { described_class.add(todo1['title'], todo1['deadline'], todo1['completed']) }
      it 'marks the todo as completed' do
        described_class.complete(todo1['title'])
        expect(described_class.all.filter { |todo| todo['title'] == todo1['title'] }.first['completed']).to be(true)
      end
    end

    context 'when the todo does not exist' do
      it 'raises a DoesNotExistError' do
        expect { described_class.complete(todo1['title']) }.to raise_error(described_class::DoesNotExistError)
      end
    end

    context 'when the todo is already completed' do
      before do
        described_class.add(todo1['title'], todo1['deadline'], todo1['completed'])
        described_class.complete(todo1['title'])
      end
      it 'raises an AlreadyCompletedError' do
        expect { described_class.complete(todo1['title']) }.to raise_error(described_class::AlreadyCompletedError)
      end
    end
  end

  describe '.remove' do
    context 'when the todo exists' do
      before { described_class.add(todo1['title'], todo1['deadline'], todo1['completed']) }
      it 'removes the todo' do
        described_class.remove(todo1['title'])
        expect(described_class.all.map { |todo| todo['title'] }).not_to include(todo1['title'])
      end
    end

    context 'when the todo does not exist' do
      it 'raises a DoesNotExistError' do
        expect { described_class.remove(todo1['title']) }.to raise_error(Todos::DoesNotExistError)
      end
    end
  end

  describe '.clear' do
    before do
      described_class.add(todo1['title'], DateTime.now, false)
      described_class.add(todo2['title'], DateTime.now, false)
    end

    it 'removes todos that match the titles provided' do
      described_class.clear([todo1['title']])
      titles = described_class.all.map { |todo| todo['title'] }
      expect(titles).not_to include(todo1['title'])
      expect(titles).to include(todo2['title'])
    end
  end
end