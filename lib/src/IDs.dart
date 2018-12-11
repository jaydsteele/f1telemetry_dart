/// The packetId of a PacketHeader
class PacketId {
  static const int motion = 0;
  static const int session = 1;
  static const int lap = 2;
  static const int event = 3;
  static const int participants = 4;
  static const int carSetups = 5;
  static const int carTelemetry = 6;
  static const int carStatus = 7;
}

/// The identifier for a session type.
///
/// See [PacketSessionData.sessionType]
class SessionType {
  static const unknown = 0;
  static const p1 = 1;
  static const p2 = 2;
  static const p3 = 3;
  static const shortP = 4;
  static const q1 = 5;
  static const q2 = 6;
  static const q3 = 7;
  static const shortQ = 8;
  static const oneShotQ = 9;
  static const r = 10;
  static const r2 = 11;
  static const timeTrial = 12;
}

/// Weather conditions
///
/// See [PacketSessionData.weather]
class Weather {
  static const clear = 0;
  static const lightCloud = 1;
  static const overcast = 2;
  static const lightRain = 3;
  static const heavyRain = 4;
  static const storm = 5;
}

/// TeamIDs
///
/// See [ParticipantData.teamId]
class TeamID {
  static const Mercedes = 0;
  static const Ferrari = 1;
  static const RedBull = 2;
  static const Williams = 3;
  static const ForceIndia = 4;
  static const Renault = 5;
  static const ToroRosso = 6;
  static const Haas = 7;
  static const McLaren = 8;
  static const Sauber = 9;
  static const McLaren_1988 = 10;
  static const McLaren_1991 = 11;
  static const Williams_1992 = 12;
  static const Ferrari_1995 = 13;
  static const Williams_1996 = 14;
  static const McLaren_1998 = 15;
  static const Ferrari_2002 = 16;
  static const Ferrari_2004 = 17;
  static const Renault_2006 = 18;
  static const Ferrari_2007 = 19;
  static const McLaren_2008 = 20;
  static const RedBull_2010 = 21;
  static const Ferrari_1976 = 22;
  static const McLaren_1976 = 34;
  static const Lotus_1972 = 35;
  static const Ferrari_1979 = 36;
  static const McLaren_1982 = 37;
  static const Williams_2003 = 38;
  static const Brawn_2009 = 39;
  static const Lotus_1978 = 40;
}

/// DriverIDs
///
/// See [ParticipantData.driverId]
class DriverID {
  static const Carlos_Sainz= 0;
  static const Daniel_Ricciardo= 2;
  static const Fernando_Alonso = 3;
  static const Kimi_Raikkonen = 16;
  static const Lewis_Hamilton= 17;
  static const Marcus_Ericsson = 8;
  static const Max_Verstappen = 9;
  static const Nico_Hulkenburg= 10;
  static const Kevin_Magnussen= 11;
  static const Romain_Grosjean = 12;
  static const Sebastian_Vettel = 13;
  static const Sergio_Perez = 14;
  static const Valtteri_Bottas = 15;
  static const Esteban_Ocon = 17;
  static const Stoffel_Vandoorne = 18;
  static const Lance_Stroll = 19;
  static const Arron_Barnes = 20;
  static const Martin_Giles = 21;
  static const Alex_Murray = 22;
  static const Lucas_Roth = 23;
  static const Igor_Correia = 24;
  static const Sophie_Levasseur = 25;
  static const Jonas_Schiffer = 26;
  static const Alain_Forest= 27;
  static const Jay_Letourneau = 28;
  static const Esto_Saari = 29;
  static const Yasar_Atiyeh = 30;
  static const Callisto_Calabresi = 31;
  static const Naota_Izum = 32;
  static const Howard_Clarke = 33;
  static const Wilheim_Kaufmann = 34;
  static const Marie_Laursen = 35;
  static const Flavio_Nieves = 36;
  static const Peter_Belousov = 37;
  static const Klimek_Michalski = 38;
  static const Santiago_Moreno = 39;
  static const Benjamin_Coppens = 40;
  static const Noah_Visser = 41;
  static const Gert_Waldmuller = 42;
  static const Julian_Quesada = 43;
  static const Daniel_Jones = 44;
  static const Charles_Leclerc = 58;
  static const Pierre_Gasly = 59;
  static const Brendon_Hartley = 60;
  static const Sergey_Sirotkin = 61;
  static const Ruben_Meijer = 69;
  static const Rashid_Nair = 70;
  static const Jack_Tremblay= 71;
}

/// DriverIDs
///
/// See [ParticipantData.nationality]
class Nationality {
  static const American = 1;
  static const Argentinean = 2;
  static const Australian = 3;
  static const Austrian = 4;
  static const Azerbaijani = 5;
  static const Bahraini = 6;
  static const Belgian = 7;
  static const Bolivian = 8;
  static const Brazilian = 9;
  static const British = 10;
  static const Bulgarian = 11;
  static const Cameroonian = 12;
  static const Canadian = 13;
  static const Chilean = 14;
  static const Chinese = 15;
  static const Colombian = 16;
  static const Costa_Rican = 17;
  static const Croatian = 18;
  static const Cypriot = 19;
  static const Czech = 20;
  static const Danish = 21;
  static const Dutch = 22;
  static const Ecuadorian = 23;
  static const Emirian = 24;
  static const English = 25;
  static const Estonian = 26;
  static const Finnish = 27;
  static const French = 28;
  static const German = 29;
  static const Ghanaian = 30;
  static const Greek = 31;
  static const Guatemalan = 32;
  static const Honduran = 33;
  static const Hong_Konger = 34;
  static const Hungarian = 35;
  static const Icelander = 36;
  static const Indian = 37;
  static const Indonesian = 38;
  static const Irish = 39;
  static const Israeli = 40;
  static const Italian = 41;
  static const Jamaican = 42;
  static const Japanese = 43;
  static const Jordanian = 44;
  static const Kuwaiti = 45;
  static const Latvian = 46;
  static const Lebanese = 47;
  static const Lithuanian = 48;
  static const Luxembourger = 49;
  static const Malaysian = 50;
  static const Maltese = 51;
  static const Mexican = 52;
  static const Monegasque = 53;
  static const New_Zealander = 54;
  static const Nicaraguan = 55;
  static const North_Korean = 56;
  static const Northern_Irish = 57;
  static const Norwegian = 58;
  static const Omani = 59;
  static const Pakistani = 60;
  static const Panamanian = 61;
  static const Paraguayan = 62;
  static const Peruvian = 63;
  static const Polish = 64;
  static const Portuguese = 65;
  static const Qatari = 66;
  static const Romanian = 67;
  static const Russian = 68;
  static const Salvadoran = 69;
  static const Saudi = 70;
  static const Scottish = 71;
  static const Serbian = 72;
  static const Singaporean = 73;
  static const Slovakian = 74;
  static const Slovenian = 75;
  static const South_African = 76;
  static const South_Korean = 77;
  static const Spanish = 78;
  static const Swedish = 79;
  static const Swiss = 80;
  static const Taiwanese = 81;
  static const Thai = 82;
  static const Turkish = 83;
  static const Ukrainian = 84;
  static const Uruguayan = 85;
  static const Venezuelan = 86;
  static const Welsh = 87;
}


