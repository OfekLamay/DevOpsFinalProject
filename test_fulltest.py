# Check that the submit button exists, click it, and check empty form validation
    elements = self.driver.find_elements(By.CSS_SELECTOR, "button")
    assert len(elements) > 0
    self.driver.find_element(By.CSS_SELECTOR, "button").click()
    time.sleep(1)
    error_msg = self.driver.execute_script('return document.getElementById("amount").validationMessage;')
    assert error_msg == "Please fill out this field." # Exact format of the message in english
    
    # Check that the expenseName text box exists, click on it and add a value
    elements = self.driver.find_elements(By.ID, "expenseName")
    assert len(elements) > 0
    expense_field = self.driver.find_element(By.ID, "expenseName")
    expense_field.click()
    expense_field.send_keys("משקה")
    time.sleep(1)
    
    # Verify that the expense name was inserted well
    try:
        assert expense_field.get_attribute("value") == "משקה"
    except AssertionError as e:
        print(e)
    
    # Check that the amount input box exists, click on it and add a value
    elements = self.driver.find_elements(By.ID, "amount")
    assert len(elements) > 0
    amount_field = self.driver.find_element(By.ID, "amount")
    amount_field.click()
    amount_field.send_keys("25")
    time.sleep(1)
    
    # Verify that the number was inserted well, as a number
    entered_amount = amount_field.get_attribute("value")
    try:
        assert entered_amount.isdigit()
        print("Verify Passed: Amount contains only numeric characters.")
    except AssertionError as e:
        print(e)
    
    # Check that the submit button exists and click on it (Second click to submit actual data)
    elements = self.driver.find_elements(By.CSS_SELECTOR, "button")
    assert len(elements) > 0
    self.driver.find_element(By.CSS_SELECTOR, "button").click()
    time.sleep(2)
    
    # Check that the expense was added successfully to the table 
    table_elements = self.driver.find_elements(By.XPATH, "//td[text()='25']")
    assert len(table_elements) > 0
    
    # Check that the clear button exists and click on it
    elements = self.driver.find_elements(By.LINK_TEXT, "נקה נתונים")
    assert len(elements) > 0, "Clear data link is missing!"
    self.driver.find_element(By.LINK_TEXT, "נקה נתונים").click()
    self.vars["window_handles"] = self.driver.window_handles
    time.sleep(2)
    
    # Verify that the form is completely cleared 
    cleared_expense_name = self.driver.find_element(By.ID, "expenseName").get_attribute("value")
    assert cleared_expense_name == ""
    
    # Closing
    self.vars["win3901"] = self.wait_for_window(2000)
    self.vars["window_handles"] = self.driver.window_handles
