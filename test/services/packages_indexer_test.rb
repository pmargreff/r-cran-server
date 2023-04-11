require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class PackagesIndexerTest < ActiveSupport::TestCase
  setup do
    @server = file_fixture("small_server/").to_s
  end

  test 'packages are created as expected' do
    Sidekiq::Testing.inline! do
      packages_indexer = PackagesIndexer.new
      packages_indexer.call(@server)

      # Test that the packages are created in the database
      assert_equal 3, Package.count

      # Test that the packages have the correct attributes
      a3_package = Package.find_by(name: 'A3')
      assert_equal '027ebdd8affce8f0effaecfcd5f5ade2', a3_package.md5

      assert_not_nil a3_package.license
      assert_not_empty a3_package.authors
      assert_not_empty a3_package.dependencies
      assert_not_empty a3_package.versions

      aalen_johansen_package = Package.find_by(name: 'AalenJohansen')
      assert_equal 'd7eb2a6275daa6af43bf8a980398b312', aalen_johansen_package.md5

      assert_not_nil aalen_johansen_package.license
      assert_not_empty aalen_johansen_package.authors
      assert_empty aalen_johansen_package.dependencies
      assert_not_empty aalen_johansen_package.versions

      aat_tools_package = Package.find_by(name: 'AATtools')
      assert_equal 'bc59207786e9bc49167fd7d8af246b1c', aat_tools_package.md5

      assert_not_nil aat_tools_package.license
      assert_not_empty aat_tools_package.authors
      assert_not_empty aat_tools_package.dependencies
      assert_not_empty aat_tools_package.versions
    end
  end
end
