@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
}
@Search.searchable: true
define view entity ZSRS_I_Connections_I
  as select from /dmo/connection as Connection
  association [0..*] to ZSRS_I_Flight_I  as _Flight  on  $projection.CarrierId    = _Flight.CarrierId
                                                     and $projection.ConnectionId = _Flight.ConnectionId
  association [0..1] to ZSRS_I_Carrier_I as _Carrier on  $projection.CarrierId = _Carrier.CarrierId
{
      @UI.facet: [{ id: 'Connection',
       purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      position: 10,
      label:'Connection' },
      { id: 'Flight',
        purpose: #STANDARD,
        type: #LINEITEM_REFERENCE,
        position: 20,
        label:'Flights',
        targetElement: '_Flight' }]
      @UI.lineItem: [{ position: 10, label: 'Airline' }]
      @UI.identification: [{ position: 10, label: 'Airline' }]
      @ObjectModel.text.association: '_Carrier'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 30, label: 'Departure Airport Id' }] // This is for header screen list
      @UI.identification: [{ position: 30, label: 'Departure Airport Id' }] // This is for Facet
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZSRS_I_Airport_I', element: 'AirportId' } }]
      airport_from_id as AirportFromId,
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZSRS_I_Airport_I', element: 'AirportId' } }]
      @EndUserText.label: 'Destination Airport Id' // Using this it will change all the palces 
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50, label: 'Departure At' }]
      @UI.identification: [{ position: 50 }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60, label: 'Arrival At' }]
      @UI.identification: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @UI.lineItem: [{ position: 70 }]
      @UI.identification: [{ position: 70 }]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      distance_unit   as DistanceUnit,

      /*Associations*/
      @Search.defaultSearchElement: true
      _Flight,
      @Search.defaultSearchElement: true
      _Carrier
}
