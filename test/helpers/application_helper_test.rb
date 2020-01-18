class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title, 'Sherlock App'
    assert_equal full_title('Contact'), 'Contact | Sherlock App'
  end
end
