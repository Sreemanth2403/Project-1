public with sharing class ApiDevProject {
    public ApiDevProject() {}
        @AuraEnabled(cacheable=true)
        public static List<PhoneWrapper>getPhoneData(){
         List<PhoneWrapper> results = new List<PhoneWrapper>();
          http http = new Http();
         HttpRequest request = new HttpRequest();
         request.setEndpoint('https://api.restful-api.dev/objects');
         request.setMethod('GET');
         HttpResponse response = http.send(request);
 
         if (response.getStatusCode() == 200) {
            List<Object> jsonList = (List<Object>) JSON.deserializeUntyped(response.getBody());
 
            for (Object item : jsonList) {
                Map<String, Object> phoneMap = (Map<String, Object>) item;
                String id = (String) phoneMap.get('id');
                String name = (String) phoneMap.get('name');
                Map<String, Object> dataMap = (Map<String, Object>) phoneMap.get('data');
            
                Specification spec; 
 
                if (dataMap != null) {
                    Map<String, Object> normalized = new Map<String, Object>();
                    for (String key : dataMap.keySet()) {
                        String normalizedKey = key.replaceAll('\\s+', '').toLowerCase();
                        normalized.put(normalizedKey, dataMap.get(key));
                    }
 
                    spec = new Specification(
                        (String) normalized.get('color'),
                        (String) normalized.get('capacity'),
                        normalized.containsKey('capacitygb') ? String.valueOf(normalized.get('capacitygb')) : null,
                        normalized.containsKey('price') ? String.valueOf(normalized.get('price')) : null,
                        normalized.containsKey('cpumodel') ? String.valueOf(normalized.get('cpumodel')) : null,
                        normalized.containsKey('harddisksize') ? String.valueOf(normalized.get('harddisksize')) : null,
                        normalized.containsKey('generation') ? String.valueOf(normalized.get('generation')) : null,
                        normalized.containsKey('year') ? String.valueOf(normalized.get('year')) : null,
                        normalized.containsKey('strapcolour') ? String.valueOf(normalized.get('strapcolour')) : null,
                        normalized.containsKey('casesize') ? String.valueOf(normalized.get('casesize')) : null,
                        normalized.containsKey('description') ? String.valueOf(normalized.get('description')) : null,
                        normalized.containsKey('screensize') ? String.valueOf(normalized.get('screensize')) : null
                    );
               
                PhoneWrapper wrapper = new PhoneWrapper(name, id, spec);
                    results.add(wrapper);
                }
            }
        }
           
       
            for (PhoneWrapper phone : results) {
                System.debug('-----------------------------------');
                System.debug('ID: ' + phone.id);
                System.debug('Name: ' + phone.name);
                if (phone.data != null) {
                    System.debug('Color: ' + phone.data.colour);
                    System.debug('Capacity: ' + phone.data.capacity);
                    System.debug('CapacityGB: ' + phone.data.capacityGB);
                    System.debug('Price: ' + phone.data.price);
                    System.debug('CPUmodel: ' + phone.data.CPUmodel);
                    System.debug('Generation: ' + phone.data.Generation);
                    System.debug('year: ' + phone.data.year);
                    System.debug('StrapColour: ' + phone.data.StrapColour);
                    System.debug('CaseSize: ' + phone.data.CaseSize);
                    System.debug('Description: ' + phone.data.Description);
                    System.debug('Screensize: ' + phone.data.Screensize);
                } else {
                    System.debug('No specification data found.');
                }
            }
             return results;
           }
          
     
    public class PhoneWrapper {
         @AuraEnabled public String name;
         @AuraEnabled public String id;
         @AuraEnabled public Specification data;

          public PhoneWrapper(String name, String id, Specification data) {
            this.name = name;
            this.id = id;
            this.data = data;
        }
    }
 
    public class Specification {
       @AuraEnabled public String colour;
       @AuraEnabled public String capacity;
       @AuraEnabled public String capacityGB;
       @AuraEnabled public String price;
       @AuraEnabled public String CPUmodel;
       @AuraEnabled public String Harddisksize;
       @AuraEnabled public String Generation;
       @AuraEnabled public String year;
       @AuraEnabled public String StrapColour;
       @AuraEnabled public String CaseSize;
       @AuraEnabled public String Description;
       @AuraEnabled public String Screensize;

 
        public Specification(String colour, String capacity, String capacityGB, String price, String CPUmodel, String Harddisksize, String Generation, String year,String StrapColour, String CaseSize, String Description, String Screensize){
            this.colour = colour;
            this.capacity = capacity;
            this.capacityGB = capacityGB;
            this.price = price;
            this.CPUmodel= CPUmodel;
            this.Harddisksize =Harddisksize;
            this.Generation = Generation;
            this.year =year;
            this.StrapColour =StrapColour;
            this.CaseSize = CaseSize;
            this.Description =Description;
            this.Screensize= Screensize;
         }
     }
 }