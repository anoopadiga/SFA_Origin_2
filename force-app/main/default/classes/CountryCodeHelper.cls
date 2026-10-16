public class CountryCodeHelper {
  public static String getCountryCode(String country) {

    //SOQL replaced with OOTB getInstance method to fetch the custom metadata
    Country_Code__mdt countryCode = Country_Code__mdt.getInstance(country);
  
    return countryCode.Country_Code__c;
  }
}