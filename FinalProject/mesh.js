class mesh{
    constructor(_bathrooms, _nodes){
        this.bath = _bathrooms
        this.nodes = _nodes
    }

    draw(){
        fill(0)
        for(let k in this.nodes){
            nodes[k].draw()
        }
    }
}