
type TCI = Worker * Vote; 

datatype TCO = WDecision of Worker * Decision
	     | SDecision of Decision; 

datatype tcevent = InEvent of TCI | OutEvent of TCO;

