
$(() => {

    window.addEventListener('message', (e) => {
        const ed = e.data;

        if (ed.type == 'state') {
            if (ed.status == true) {
                $(".container").show();
            } else if (ed.status == false) {
                $(".container").hide();
            }
        } else if (ed.type == 'update') {
            let players = ed.players;

            $(".players").empty()
            for ( let i = 0; i < ed.players.length; i++ ) {
                setupPlayer(players[i])
            }

            $(".online-jobs").empty()
            for (const key in ed.jobs) {
                setupJob(ed.jobs[key]);
            }

            changePlayers(`Spillere: ${ed.activePlayers}/${ed.maxPlayers}`)
            changeMyId(`Mit ID: ${ed.myid}`)
        }
    })
    
    function setupJob(job) {
        $(".online-jobs").append(`<div class="job">${job.label}: ${job.online}</div>`)
    }

    function setupPlayer(player) {
        $(".players").append(`
            <div class="player">
                <div class="icon">
                    <div class="icon-ring">
                        <i class="fa-solid fa-user"></i>
                    </div>
                </div>
                
                <div class="name">
                    <p>${player.name}</p>
                </div>
            </div>
        `)
    }

    function changePlayers(player) {
        $("#players").html(player)
    }

    function changeMyId(idString) {
        $("#myid").html(idString)
    }
})
