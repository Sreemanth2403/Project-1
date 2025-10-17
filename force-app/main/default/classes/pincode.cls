public  class pincode {
    public static void pincode(String Pincode) {
        HttpRequest request = new HttpRequest();
         request.setEndpoint('callout:postalcode/'+ Pincode);
         request.setMethod('GET');
         Http h= new Http();
         HttpResponse response = h.send(request);
         List<pincodewrapper> wrapperList = (List<pincodewrapper>) JSON.deserialize(response.getBody(), List<pincodewrapper>.class); 
         if (!wrapperList.isEmpty()) {
         for(pincodewrapper wrapper:wrapperList){
            system.debug(wrapper);
            system.debug(wrapper.Status);
            system.debug(wrapper.Message);
            system.debug(wrapper.PostOffice);
         }
         }
        }         
    public class pincodewrapper{
        public String Message;
        public String Status;
        public List<PostOffice> PostOffice;
    }
    
   public class PostOffice{
        public String Name;
        public String Description;
        public String BranchType;
        public String DeliveryStatus;
        public String Circle;
        public String District;
        public String Division;
        public String Region;
        public String Block;
        public String State;
        public String Country;
        public String Pincode;
            
        
        } 
    }
    


