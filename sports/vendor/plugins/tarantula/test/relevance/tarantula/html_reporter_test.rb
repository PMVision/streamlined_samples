require File.join(File.dirname(__FILE__), "..", "..", "test_helper.rb")

describe "Relevance::Tarantula::HtmlReporter file output" do
  include Relevance::Tarantula
  before do
    FileUtils.rm_rf(test_output_dir)
    FileUtils.mkdir_p(test_output_dir)
    Relevance::Tarantula::Result.next_number = 0
    @results = (1..10).map do |index|
      Relevance::Tarantula::Result.new(
        :success => true, 
        :method => "get", 
        :url => "/widgets/#{index}", 
        :response => stub(:code => 200, :body => "<h1>header</h1>\n<p>text</p>"), 
        :referrer => "/random/#{rand(100)}", 
        :log => "sample log value",
        :data => "{:param1 => :value, :param2 => :another_value}"
      )
    end
    @index = File.join(test_output_dir, "index.html")
    FileUtils.rm_f @index
    @detail = File.join(test_output_dir, "1.html")
    FileUtils.rm_f @detail
  end
  
  it "creates a report based on tarantula results" do
    results = stub_everything(:successes => @results, :failures => @results)
    # ERB::Util.expects(:h).with(:foo).returns(:data_stub)
    Relevance::Tarantula::HtmlReporter.report(test_output_dir, results)
    File.should.exist @index
    File.should.exist @detail
  end

end

describe "Relevance::Tarantula::HtmlReporter output processing" do
  include Relevance::Tarantula
  def turn_off_report_output
    Relevance::Tarantula::HtmlReporter.any_instance.stubs(:output)
  end
  
  before do
    turn_off_report_output
    @result = Relevance::Tarantula::Result.new(
        :success => true, 
        :method => "stub_method", 
        :url => "stub_url",
        :response => stub(:code => 200, :body => "stub_body"), 
        :referrer => "stub_referrer", 
        :data => "stub_data"
    )
  end

  it "html escapes the data and body sections" do
    @results = stub_everything(:successes => [], :failures => [@result])
    ERB::Util.expects(:h).with("stub_data")
    ERB::Util.expects(:h).with("stub_body")
    Relevance::Tarantula::HtmlReporter.report(test_output_dir, @results)
  end
end