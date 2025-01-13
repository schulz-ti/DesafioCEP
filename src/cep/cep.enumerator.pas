unit cep.enumerator;

interface

type
  TTipoChaveEnu = (tCEP, tEndereco);

  TTipoPesquisaEnu = (ctpJson, ctpXml);

  THelperTipoPesquisaEnumerator = record Helper for TTipoPesquisaEnu
  public
    function ToInteger: integer;
  end;

implementation

{ THelperTipoPesquisaEnumerator }

function THelperTipoPesquisaEnumerator.ToInteger: integer;
begin
  result := integer(self);
end;

end.
