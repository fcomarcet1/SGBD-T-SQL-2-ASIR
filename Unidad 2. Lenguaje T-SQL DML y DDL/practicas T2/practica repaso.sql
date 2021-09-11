

------------------------------------------------------------------------
select strNombre,srtTelefono from tblPacientes;

------------------------------------------------------------------------------
------------------------------------------------------------------------------

select strNombre,strDireccion + ',' + strCiudad  AS residencia
from tblpacientes;

------------------------------------------------------------------------------
------------------------------------------------------------------------------


select strNombre  from tblpacientes
where  strTelefono IS NULL OR strCiudad NOT LIKE 'Alicante'

------------------------------------------------------------------------------
------------------------------------------------------------------------------


use clinica

SELECT DISTINCT tblpacientes.strNombre 
INTO CopiaPacientesAlicante
FROM tblpacientes
INNER JOIN tblvisitas
on tblpacientes.intCodigo = tblvisitas.intCodigopaciente
where strCiudad = 'ALICANTE';

------------------------------------------------------------------------------
------------------------------------------------------------------------------

SELECT tblpacientes.strNombre,tblvisitas.dtmFecha
FROM tblpacientes
INNER JOIN tblvisitas
on tblpacientes.intCodigo = tblvisitas.intCodigopaciente
where (strCiudad = 'ALICANTE' )AND 
	  (dtmFecha BETWEEN '2019-01-01' AND '2019-06-01')
ORDER BY strNombre DESC

------------------------------------------------------------------------------
------------------------------------------------------------------------------

SELECT SUM(intImporte) AS ImporteTotal
FROM tblvisitas,tblPacientes
WHERE strCiudad NOT LIKE 'ALICANTE'
AND intCodigo = intCodigopaciente;


------------------------------------------------------------------------------
------------------------------------------------------------------------------

SELECT count(*)
FROM tblvisitas
WHERE year = 2019
GROUP BY month (dtmFecha);

------------------------------------------------------------------------------
------------------------------------------------------------------------------

SELECT strNombre
FROM tblvisitas,tblpacientes
WHERE intImporte >50
AND intCodigo = intCodigopaciente;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
INSERT INTO tblResumenPacientes(nombre,año,totalgastado)
	SELECT SUM (intImporte)
	FROM tblvisitas
	WHERE year = 2018;


-----------------------------------------------------------------------------
------------------------------------------------------------------------------


DELETE FROM CopiaPacientes
WHERE strNombre LIKE ' %G% ' ;