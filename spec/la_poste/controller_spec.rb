# frozen_string_literal: true

RSpec.describe LaPoste::Controller do
  let(:controller) { described_class.new }

  describe "#from_file_to_stdout" do
    subject(:process) { controller.from_file_to_stdout(filename) }

    context "when file is (relatively) big" do
      let(:filename) { "spec/support/input_big.txt" }

      it "returns result to STDOUT" do
        expected_output = File.read("spec/support/output_big.txt")
        expect { process }.to output(expected_output).to_stdout
      end
    end

    context "when file is small" do
      let(:filename) { "spec/support/input_small.txt" }

      it "returns result to STDOUT" do
        expected_output = File.read("spec/support/output_small.txt")
        expect { process }.to output(expected_output).to_stdout
      end
    end

    context "when file is in wrong format" do
      let(:filename) { "spec/support/input_wrong_format.txt" }

      it "returns result to STDOUT" do
        expected_output = File.read("spec/support/output_wrong_format.txt")
        expect { process }.to output(expected_output).to_stdout
      end
    end

    context "when file is empty" do
      let(:filename) { "spec/support/input_empty.txt" }

      it "returns nothing to STDOUT" do
        expect { process }.not_to output.to_stdout
      end
    end

    context "when file is not found" do
      let(:filename) { "spec/support/input_not_found.txt" }

      it "returns error to STDOUT" do
        expected_output = "File \"#{filename}\" is not found\n"
        expect { process }.to output(expected_output).to_stdout
      end
    end
  end
end
