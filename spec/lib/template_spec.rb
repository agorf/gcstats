require 'spec_helper'

describe Template do
  it 'should convert ERB to HTML' do
    Template.new('My name is <%= @name %>', :name => 'Aggelos').result.should == 'My name is Aggelos'
  end

  it 'should not escape HTML by default' do
    Template.new('Use <%= @tag %> for <%= @desc %>', :tag => '<b>', :desc => 'bold').result.should == 'Use <b> for bold'
  end

  it 'should escape HTML where h() helper is used' do
    Template.new('Use <%=h @tag %> for <%= @desc %>', :tag => '<b>', :desc => 'bold').result.should == 'Use &lt;b&gt; for bold'
  end
end
