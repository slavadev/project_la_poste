# frozen_string_literal: true

require "rake"

RSpec.describe Rake::Task do
  describe "run" do
    subject(:invoke) { task.invoke(filename) }

    let(:task) { described_class["run"] }
    let(:controller) { instance_spy("LaPoste::Controller") }

    before do
      Rake.load_rakefile("Rakefile") unless described_class.task_defined?("run")
      task.reenable
      allow(LaPoste::Controller).to receive(:new).and_return(controller)
    end

    context "when filename is provided" do
      let(:filename) { "custom_input.txt" }

      it "calls the controller with provided filename" do
        invoke
        expect(controller).to have_received(:from_file_to_stdout).with(filename)
      end
    end

    context "when filename is not provided" do
      let(:filename) { nil }

      it "calls the controller with default filename" do
        invoke
        expect(controller).to have_received(:from_file_to_stdout).with("input.txt")
      end
    end
  end
end
