
import unittest
import os
import testLib

class TestFunctions(testLib.RestTestCase):
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'})
        self.assertResponse(respData, count = 1)

    def testAdd2(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'})
        respData2 = self.makeRequest("/users/add", method="POST",
        data = { 'user' : 'user1', 'password' : 'password'})
        self.assertEquals(respData2['errCode'], testLib.RestTestCase.ERR_USER_EXISTS)

    def testAdd3(self):
        longusername = "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
        respData = self.makeRequest("/users/add", method="POST",
                                    data = { 'user' : longusername, 'password' : 'password'})
        self.assertEquals(respData['errCode'], testLib.RestTestCase.ERR_BAD_USERNAME)

    def testlogin1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'})
        respData2 = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'})
        self.assertResponse(respData2, count = 2)

    def testlogin2(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'})
        self.assertEquals(respData['errCode'], testLib.RestTestCase.ERR_BAD_CREDENTIALS)

    def testlogin3(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : ' ', 'password' : ''})
        respData2 = self.makeRequest("/users/login", method="POST", data = { 'user' : ' ', 'password' : ''})
        self.assertResponse(respData2, count = 2)
        
