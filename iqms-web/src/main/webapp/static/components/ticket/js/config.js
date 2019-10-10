var appConfig = {
  "name": "奥拓电子自助系统",
  "device": {
    "supplier": "aoto",
    "no": "100101",
    "orgCode": "1001",
    "id": 3,
    "orgId": 2468,
    "orgName": "奥拓电子"
  },
  "webServer": {
    "host": "localhost",
    "port": 8998,
    "contextPath": "/pps",
    "timeout": 5000
  },
  "tcpServer": {
    "host": "172.16.210.137",
    "port": 8998,
    "sendBufferSize": 1024,
    "receiveBufferSize": 1024,
    "sendTimeout": 5000,
    "receiveTimeout" :5000
  },
  "peripheral": {
    "dir": "aoto",
    "statusInterval": 600,
    "type" : 7,
    "barScreen": { "dll": "AOTO_BERR_2014.dll", "timeout": 10000, "enabled": true, "logLevel" : 0 },
    "compScreen": { "dll": "AOTO_COMP_2014.dll", "timeout": 10000, "enabled": true, "logLevel" : 0 },
    "evaluator": { "dll": "AOTO_APPR_2014.dll", "timeout": 10000, "enabled": true, "logLevel" : 0 },
    "caller": { "dll": "AOTO_CALL_2014.dll", "timeout": 10000, "enabled": true, "logLevel" : 0 },
    "icCardReaderWriter": { "dll": "AOTO_ICCR_2014_USB.dll", "timeout": 10000, "enabled": true, "logLevel" : 0, "index": 1 },
    "idCardReader": { "dll": "AOTO_IDCR_2014.dll", "timeout": 10000, "enabled": true, "logLevel" : 0, "index": 0 },
    "magneticCardReaderWriter": { "dll": "AOTO_CRDR_2014_COM.dll", "timeout": 10000, "enabled": true, "logLevel" : 0, "track": 23 },
    "needlePrinter": { "dll": "HWXPrinterLib.dll", "timeout": 10000, "enabled": true, "name" : "EPSON LQ-90KP ESC/P2" },
    "thermalPrinter": { "dll": "", "timeout": 10000, "enabled": true, "name" : "BT-T080R(U) 1" },
    "voicePlayer": { "dll": "AOTO_VOIC_2014.dll", "timeout": 10000, "enabled": true, "logLevel": 0 }
  },
  "custRec": {
    "online": true,
    "url": ""
  },
  "runMode": {
    "model": "single",
    "webServer": {
        "host": "+",
        "port": 80,
        "contextPath": "/qms",
        "timeout": 5000
    },
    "mappings":[
        {"path": "/services/tickets/fetch", "id":"ticketService", "method": "GetTicket"},
        {"path": "/services/tickets/call", "id":"ticketService", "method": "CallTicket"},
        {"path": "/services/tickets/recall", "id":"ticketService", "method": "RecallTicket"},
        {"path": "/services/tickets/rate", "id":"ticketService", "method": "RateCallback"},
        {"path": "/services/tickets/signin", "id":"ticketService", "method": "Signin"},
        {"path": "/services/tickets/signout", "id":"ticketService", "method": "Signout"},
        {"path": "/services/tickets/transfer", "id":"ticketService", "method": "TransferTicket"},
        {"path": "/services/tickets/aptcall", "id":"ticketService", "method": "AptcallTicket"},
        {"path": "/services/tickets/delay", "id":"ticketService", "method": "DelayTicket"},
        {"path": "/services/tickets/lock", "id":"ticketService", "method": "LockTicket"},
        {"path": "/services/tickets/unlock", "id":"ticketService", "method": "UnlockTicket"},
        {"path": "/services/tickets/isEffectQueueNo", "id":"ticketService", "method": "IsEffectQueueNo"},
        {"path": "/services/tickets/waiting", "id":"ticketService", "method": "GetWaitingCount"},
        {"path": "/services/tickets/todayBizReport", "id":"ticketService", "method": "TodayBizReport"},
        {"path": "/services/tickets/yesterdayBizReport", "id":"ticketService", "method": "YesterdayBizReport"},
		{"path": "/services/tickets/pause", "id":"ticketService", "method": "Pause"}
    ]
  },
  "heartbeatInterval": 30,
  "online": false,
  "timeout": 60,
  "callLang": "MANDARIN",
  "ticketTimeout": 10,
  "ticketBtnTimeout": 0.5,
  "ppsPopUpTimeout":3,
  "screenResolution":"1366x768",
  "mode": 2,
  "topMost": false,
  "webBrowser": {
    "scriptErrorsSuppressed": true,
    "scrollBarsEnabled": false
  },
  "opacity": 0.75,
  "version": "2.2"
};

var advConfig = [
	{"id":"1","name":"pict01","ext":".jpg","timeout":1000},
	{"id":"2","name":"pict02","ext":".jpg","timeout":2000},
	{"id":"3","name":"pict03","ext":".jpg","timeout":3000},
	{"id":"4","name":"pict04","ext":".jpg","timeout":4000}
];

var appState = {"online":false,"currentStyleId":3,"currentQmsConfigStyleId":0};
