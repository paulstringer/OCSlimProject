XCODE_USER_TEST_TEMPLATES_DIR=~/Library/Developer/Xcode/Templates/Test

TEMPLATES_DIR=Xcode\ Templates/

install_templates:
	mkdir -p $(XCODE_USER_TEST_TEMPLATES_DIR)
	cp -R $(TEMPLATES_DIR) $(XCODE_USER_TEST_TEMPLATES_DIR)
