# Data Schema

## Model classes
Available on Google Doc [Models](http://tinyurl.com/shakeel-models)

## Database Tables
Available on Google Doc [Tables](http://tinyurl.com/shakeel-tables)

## API endpoints

- USPS, UPS, and FedEx APIs to generate prepaid shipping label PDFs
 - using a replica to avoid API service fees during development
 - requires the ``Shipment`` model class (see "Model classes" above)
- [IMEIData.net](https://imeidata.net/) to determine device details using an IMEI number
 - using a replica to avoid API service fees during development
 - requires the ``Device`` model class (see "Model classes" above)
- [SNDeep.info](http://sndeep.info/en) to determine device details using a Serial number
 - using a replica to avoid API service fees during development
 - requires the ``Device`` model class (see "Model classes" above)
- Instagram API to showcase [Shakeel](https://www.yelp.com/biz/shakeel-the-iphone-repair-guy-south-san-francisco-2)'s latest [work and statuses](https://www.instagram.com/iphonerepairguy/)
 - requires the ``InstagramPhoto`` model class (see "Model classes" above)
