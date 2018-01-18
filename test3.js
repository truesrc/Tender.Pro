Feature('Test for tender.pro');

let assert = require('assert');
let unirest = require('unirest');

/* 
В первом тесте позитивно тестируется блок регистрации. Используется CodeceptJS + NodeJS + Selenium WebDriver.
*/
Scenario('UI тест', (I) => {
  I.amOnPage('http://www.tender.pro/');
  I.see('Регистрация');
  I.click('Регистрация');
  I.see('Регистрация. Шаг 1. Создайте учетную запись');
   within('.blockArticle', () => {
    I.fillField('#login', 'User'+ Math.random());
    I.fillField('#email', 'user@user.com');
	I.selectOption('#acclang', 'ru');
    I.fillField('#name_last', 'Иванов');
    I.fillField('#name_first', 'Иван');
    I.fillField('#name_patronymic', 'Иванович');		
    I.fillField('#position', 'Гендир');		
    I.fillField('#dept', 'Администрация');		
    I.fillField('#phone', '+7-912-866-12-34');
	I.checkOption('#agreement');	
	I.click('button');
    });
   I.waitForText('Благодарим Вас за регистрацию!', 5);
   I.see('Благодарим Вас за регистрацию!');
   
});

/* 
В втором тесте тестируется соответствие ожидаемого и получаемого на клиенте Типа результата:app.company_info_public. 
Используется CodeceptJS + NodeJS + Selenium WebDriver.
*/ 
Scenario('REST API test ', function*(I){
    unirest.get('http://www.tender.pro/api/_company.info_public.json?id=198').end((responseFromApi) => {
        let response = JSON.parse(responseFromApi.body);
        let expectedAttributes = [
           "address_legal",
           "title_full",
           "anno_short",
           "rating",
           "is_seller_producer",
           "country_id",
           "fax",
           "is_type_seller",
           "address",
           "id",
           "anno",
           "type_name",
           "country_name",
           "phone",
           "seller_type_name",
           "kpp",
           "inn",
           "site",
           "title"
        ];

    let receivedAttributes = Object.keys(response.result.data);
    assert.deepEqual(expectedAttributes, receivedAttributes);
    assert.equal(response.result.data.address_legal, '650608, Россия, Абак, Советск, 244, 65');

    });
});
