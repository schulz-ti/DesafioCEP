unit cep.factory.interfaces;

interface

uses
  cep.controller.interfaces,
  cep.model.interfaces,
  cep.service.interfaces;

type
  IFactoryCep = interface
    ['{A023EC15-1FC3-4088-A67B-F0BA91DA1593}']
    function Controller: ICEPController;
    function Model: ICEPModel;
    function Service: ICEPServiceContext;
  end;

implementation

end.
