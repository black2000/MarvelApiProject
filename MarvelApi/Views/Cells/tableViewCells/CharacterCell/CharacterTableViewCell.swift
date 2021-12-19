//
//  CharacterTableViewCell.swift
//  MarvelApi
//
//  Created by lapshop on 11/27/21.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    
    override func layoutSubviews() {
        self.characterImageView.layer.cornerRadius = 10
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.shadowRadius = 10
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 1
        self.containerView.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    func configureCell(with character:MarvelCharacter) {
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = !(character.description?.isEmpty ?? false) ?  character.description : "no description"
        if let imageUrl = EndPoint.getSizedMarvelCharacterImage(path: character.thumbnail.path, extension: character.thumbnail.fileExtension, imageSize: .portraitIncredible).url {
            characterImageView.downloadImage(With: imageUrl)
        }
    }
}
