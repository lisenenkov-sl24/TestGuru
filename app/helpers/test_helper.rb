module TestHelper
  def test_edit_header(test)
    return "Edit #{test.title} Test" if test.persisted?

    "Create New #{test.title} Test"
  end
end
