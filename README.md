# TestingTask
Testing Task for iOS-developer position

## Testing task for mobile developers
[We have a simple HLS stream available on the following URL:] (http://pubcache1.arkiva.de/test/hls_index.m3u8)
It contains two audio tracks and several video tracks.
We need to have an app which implements an simply audio player. 
The player should be **a circle** which can contains the following **states**:
- Uninitialized: Showing the play button in the middle of the circle
- Fetching the audio file: Showing a **simple spinner** in the middle of the circle
- Playing the audio file back: Showing a **pause button** in the middle of the circle
- Paused: Showing **the play button** in the middle of the circle
- Completed: Showing a **spinner** in the middle of the circle
1. At the start the player is located in **the middle of the screen, centered**.
2. From the state "uninitialized": **On tap** it will change its state to "fetching".
In the state "fetching": It should fetch the audio track with **the highest quality** from the aforementioned HLS file, 
chunck by chunck using **two concurrent threads** - meaning: download up to two chunks at a time - and store it into a local 
file which is **a concatenated** version of the chunks. Writing to the file should happen while **the chunks arrive** and not 
at the very end. When a chunk is written to the file on disk it should be **deleted from memory**. The player circule should 
show **the progress** by **filling the circle** with **another background color**. The circle is filled completely once all 
chunks are downloaded fully. 
Feel free to integrate your own prefered visualiziaton for this. 
Once finished fetching it will switch to the playing state.
3. In the "playing" state: Playing back the local audio file. Tapping it again should switch to the state "paused" state and 
pause the playback. Once the playback is completed, switch to the "completed" state. 
Playing out a local file doesn't mean to play out the file just downloaded. ts segmented files cannot be played back from 
the player from local storage, they need the http layer. So, choose any audio file, mp3 or anything else playable to be 
actually played back for the UI task.
4. In the "paused" state: Showing the play button. Tapping it should switch to the state "playing" and resume the playback.
5. In the "completed" state: Delete the locally cached file and go back to the uninitialized state. 

Moving the circled player around:
The player is initialized in the middle of the screen centered. The user can move the player by drag and drop. He can also 
push the player with a swipe gesture towards an edge, in this case the player movement towards the respective edge should 
accelerate at the beginning and de-accelarate while getting near the edge - the player should then stick to the 
respective edge.


### Code: 
Create the code in a way that the data handler is **reusable** as a component, the player inside is a component and 
the drag and drop / push to the edge is a separate component.

### iOS specifics
#### Programming language: 
The test can be done in either swift 3 or 4
#### iOS versions: 
** Minimum iOS 8.0 **

### Frameworks: 
Cocoa pods are fine to use but it would be better to see more self written code than imported libraries. 
And the task isn’t that complicated to require importing a lot of third party libraries.

### Target device: 
**iPhone**
