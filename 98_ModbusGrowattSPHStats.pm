package main;
use strict;
use warnings;

sub ModbusGrowattSPHStats_Initialize($);

my %ModbusGrowattSPHStatsdeviceInfo = (
    "timing" => {
        timeout     =>  2,
        commDelay   =>  0.2,
        sendDelay   =>  1,
    }, 
    "i" =>  {
        combine => 10,
    },
    "h" =>  {
        combine => 10,
    }  
);

my %ModbusGrowattSPHStatsparseInfo = (
	'i91' => { reading => 'PVEnergyTotal',
				 name => 'Epv_total',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i59' => { reading => 'PV1EnergyToday',
				 name => 'Epv1_today',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i61' => { reading => 'PV1EnergyTotal',
				 name => 'Epv1_total',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i63' => { reading => 'PV2EnergyToday',
				 name => 'Epv2_today',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i65' => { reading => 'PV2EnergyTotal',
				 name => 'Epv2_total',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},                                          
	'i1044' => { reading => 'EnergyToUserToday',
				 name => 'Etouser_today',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i1046' => { reading => 'EnergyToUserTotal',
				 name => 'Etouser_total',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i1048' => { reading => 'EnergyToGridToday',
				 name => 'Etouser_today',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i1050' => { reading => 'EnergyToGridTotal',
				 name => 'Etouser_total',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
    'i1052' => { reading => 'EnergyDischargeToday',
				 name => 'Edischarge1_today',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i1054' => { reading => 'EnergyDischargeTotal',
				 name => 'Edischarge1_total',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			}, 
    'i1056' => { reading => 'EnergyChargeToday',
				 name => 'Echarge1_today',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i1058' => { reading => 'EnergyChargeTotal',
				 name => 'Echarge1_total',
                 unpack => 'I>',
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			}, 
    'i1060' => { reading => 'EnergyLocalLoadToday',
				 name => 'Elocalload_today',
                 unpack => 'I>',  
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},
	'i1062' => { reading => 'EnergyLocalLoadTotal',
				 name => 'Elocalload_total',
                 unpack => 'I>', 
                 expr => '$val / 10',
                 format => '%.1f',
                 len => 2,
                 poll => 1,            
			},                                                                        
);

sub ModbusGrowattSPHStats_Initialize($)
{
    my ($modHash) = @_;
    LoadModule "Modbus";
    require "$attr{global}{modpath}/FHEM/DevIo.pm";

    $modHash->{parseInfo}  = \%ModbusGrowattSPHStatsparseInfo;     
    $modHash->{deviceInfo} = \%ModbusGrowattSPHStatsdeviceInfo;

    ModbusLD_Initialize($modHash);
    
    $modHash->{AttrList} = $modHash->{AttrList} . " " .
        $modHash->{ObjAttrList} . " " . 
        $modHash->{DevAttrList};

}