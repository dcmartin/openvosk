#!/usr/bin/env python3

import asyncio
import websockets
import sys

async def doit(uri,file):
    async with websockets.connect(uri) as websocket:
        wf = open(file,"rb")
        while True:
            data = wf.read(8000)

            if len(data) == 0:
                break

            await websocket.send(data)
            print (await websocket.recv())

        await websocket.send('{"eof" : 1}')
        print (await websocket.recv())

asyncio.get_event_loop().run_until_complete(doit('ws://localhost:2700',sys.argv[1]))

